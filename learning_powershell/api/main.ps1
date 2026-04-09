# API using PowerShell + SQLite

# SQLite.Interop.dll (native) must be next to the script at runtime
$libDir    = "$PSScriptRoot\lib"
$interopSrc = "$libDir\SQLite.Interop.dll"
$interopDst = "$PSScriptRoot\SQLite.Interop.dll"
if ((Test-Path $interopSrc) -and -not (Test-Path $interopDst)) {
    Copy-Item $interopSrc $interopDst
}

Add-Type -Path "$libDir\System.Data.SQLite.dll"

# --- DB Setup ---
$dbPath = ".\data.db"
Get-ChildItem -Path $dbPath -ErrorAction Ignore | Out-Null
if (-not (Test-Path $dbPath)) {
    [System.Data.SQLite.SQLiteConnection]::CreateFile($dbPath)
    Write-Host "Created new SQLite database at $dbPath"
}
$connStr = "Data Source=$dbPath;Version=3;"

function Get-Connection {
    $conn = [System.Data.SQLite.SQLiteConnection]::new($connStr)
    $conn.Open()
    return $conn
}

# Create table if not exists
$conn = Get-Connection
$cmd = $conn.CreateCommand()
$cmd.CommandText = "CREATE TABLE IF NOT EXISTS items (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL)"
$cmd.ExecuteNonQuery() | Out-Null
$conn.Close()

# --- DB Helpers ---
function Get-Items {
    $conn = Get-Connection
    $cmd = $conn.CreateCommand()
    $cmd.CommandText = "SELECT id, name FROM items"
    $reader = $cmd.ExecuteReader()
    $results = @()
    while ($reader.Read()) {
        $results += @{ id = $reader["id"]; name = $reader["name"] }
    }
    $conn.Close()
    return $results
}

function Get-Item($id) {
    $conn = Get-Connection
    $cmd = $conn.CreateCommand()
    $cmd.CommandText = "SELECT id, name FROM items WHERE id = @id"
    $cmd.Parameters.AddWithValue("@id", $id) | Out-Null
    $reader = $cmd.ExecuteReader()
    $item = $null
    if ($reader.Read()) { $item = @{ id = $reader["id"]; name = $reader["name"] } }
    $conn.Close()
    return $item
}

function Add-Item($name) {
    $conn = Get-Connection
    $cmd = $conn.CreateCommand()
    $cmd.CommandText = "INSERT INTO items (name) VALUES (@name); SELECT last_insert_rowid()"
    $cmd.Parameters.AddWithValue("@name", $name) | Out-Null
    $newId = $cmd.ExecuteScalar()
    $conn.Close()
    return @{ id = $newId; name = $name }
}

function Remove-Item($id) {
    $conn = Get-Connection
    $cmd = $conn.CreateCommand()
    $cmd.CommandText = "DELETE FROM items WHERE id = @id"
    $cmd.Parameters.AddWithValue("@id", $id) | Out-Null
    $rows = $cmd.ExecuteNonQuery()
    $conn.Close()
    return $rows
}

# --- HTTP Listener ---
$listener = [System.Net.HttpListener]::new()
$listener.Prefixes.Add("http://localhost:8080/")
$listener.Start()

Write-Host "API running on http://localhost:8080/"
Write-Host "Press Ctrl+C to stop"

function Send-Response {
    param($context, $statusCode, $body)
    $json  = $body | ConvertTo-Json -Depth 5
    $bytes = [System.Text.Encoding]::UTF8.GetBytes($json)
    $context.Response.StatusCode  = $statusCode
    $context.Response.ContentType = "application/json"
    $context.Response.OutputStream.Write($bytes, 0, $bytes.Length)
    $context.Response.Close()
}

while ($listener.IsListening) {
    $context = $listener.GetContext()
    $request = $context.Request
    $method  = $request.HttpMethod
    $path    = $request.Url.AbsolutePath

    Write-Host "$method $path"

    $body = $null
    if ($request.HasEntityBody) {
        $reader = [System.IO.StreamReader]::new($request.InputStream)
        $body   = $reader.ReadToEnd() | ConvertFrom-Json
        $reader.Close()
    }

    # GET /items
    if ($method -eq "GET" -and $path -eq "/items") {
        Send-Response $context 200 (Get-Items)
    }

    # GET /items/{id}
    elseif ($method -eq "GET" -and $path -match "^/items/(\d+)$") {
        $item = Get-Item ([int]$Matches[1])
        if ($item) { Send-Response $context 200 $item }
        else        { Send-Response $context 404 @{ error = "Not found" } }
    }

    # POST /items
    elseif ($method -eq "POST" -and $path -eq "/items") {
        if (-not $body.name) { Send-Response $context 400 @{ error = "name is required" } }
        else                  { Send-Response $context 201 (Add-Item $body.name) }
    }

    # DELETE /items/{id}
    elseif ($method -eq "DELETE" -and $path -match "^/items/(\d+)$") {
        $rows = Remove-Item ([int]$Matches[1])
        if ($rows -gt 0) { Send-Response $context 200 @{ message = "Deleted" } }
        else              { Send-Response $context 404 @{ error = "Not found" } }
    }

    else {
        Send-Response $context 404 @{ error = "Route not found" }
    }
}
