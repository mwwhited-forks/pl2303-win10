class PLConsole
{
    [void] Finish([string]$message, [int32]$exitCode)
    {
        if ($message) {
            Write-Host
            Write-Host $message
        }

        try {
            Write-Host
            Read-Host -Prompt 'Press the enter key to finish'
        } catch {
            # Handle non-interactive use
        }
        exit $exitCode
    }

    [void] FinishWithHelp([string]$message)
    {
        Write-Host
        Write-Host $message
        $this.ShowHelp()
        $this.Finish([string]::Empty, 0)
    }

    [void] FinishVerbose([string]$message)
    {
        Write-Host
        Write-Host $message
        $this.ShowHelp()
        $this.ShowInfo()
        $this.Finish([string]::Empty, 0)
    }

    [void] FinishWithInfo()
    {
        Write-Host
        Write-Host 'The installed driver has been activated by Windows and is now ready for use.'
        $this.ShowInfo()
        $this.Finish([string]::Empty, 0)
    }

    [void] Indent([string]$message)
    {
        Write-Host "   $message"
    }

    [bool] PromptYes ([string]$question, [string]$default)
    {
        $prompt = "   $question [y/n]"

        try {
            $answer = Read-Host -Prompt $prompt
        } catch {
            # Handle non-interactive use
            $answer = $default
            Write-Host (-join ($prompt, ': ', $default))
        }
        return ($answer -match '^y')
    }

    [void] ShowHelp()
    {
        $this.Indent('* Unplug and plug in your USB device. Then run this script again.')
        $this.Indent('* Restart your computer. Then run this script again.')
    }

    [void] ShowInfo()
    {
        Write-Host
        Write-Host '** Windows Automatic Updates may replace this driver with the latest version.'
        Write-Host 'If this happens, you can roll back the driver to this compatible version.'
        Write-Host 'The README.txt file explains how to prevent this.'
    }
}
