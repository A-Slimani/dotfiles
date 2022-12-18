# Custom Aliases
Set-Alias c clear

# Folder Shortcuts
function cd-programming { set-location "D:/Programming" }

# AutoComplete
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete


# OH MY POSH
oh-my-posh init pwsh --config "C:\Users\aboud\.config\robbyrussel.json" | Invoke-Expression


# Import the Chocolatey Profile that contains the necessary code to enable
# tab-completions to function for `choco`.
# Be aware that if you are missing these lines from your profile, tab completion
# for `choco` will not function.
# See https://ch0.co/tab-completion for details.
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

### Codex CLI setup - start
$nl_cli_script = "D:\programming\Codex-CLI\src\codex_query.py"

# this function takes the input from the buffer and passes it to codex_query.py
function create_completion() {
    param (
        [Parameter (Mandatory = $true)] [string] $buffer
    )
    
    if ($nl_cli_script -eq "" -or !(Test-Path($nl_cli_script))) {
        Write-Output "# Please update the nl_cli_script path in the profile!"
        return "`nnotepad $profile"
    }

    $output = echo -n $buffer | python $nl_cli_script 
    
    return $output
}

Set-PSReadLineKeyHandler -Key Ctrl+g `
                         -BriefDescription NLCLI `
                         -LongDescription "Calls Codex CLI tool on the current buffer" `
                         -ScriptBlock {
    param($key, $arg)
    
    $line = $null
    $cursor = $null

    [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)

    # get response from create_completion function
    $output = create_completion($line)
    
    # check if output is not null
    if ($output -ne $null) {
        foreach ($str in $output) {
            if ($str -ne $null -and $str -ne "") {
                [Microsoft.PowerShell.PSConsoleReadLine]::AddLine()
                [Microsoft.PowerShell.PSConsoleReadLine]::Insert($str)
            }
        }
    }
}
### Codex CLI setup - end
