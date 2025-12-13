# get user permissions
whoami /priv

net use q: "\\192.168.10.50\SC scan"

function Test-Port {
    param($h, $port, $timeout = 1000)

    $client = New-Object System.Net.Sockets.TcpClient
    $async = $client.BeginConnect($h, $port, $null, $null)
    $wait = $async.AsyncWaitHandle.WaitOne($timeout, $false)
    if ($wait -and $client.Connected) {
        $client.EndConnect($async)
        $client.Close()
        return $true
    }
    return $false
}

$h = "192.168.1.10"
1..1024 | ForEach-Object {
    if (Test-Port -h $h -port $_) {
        Write-Host "Port $_ is OPEN"
    }
}

