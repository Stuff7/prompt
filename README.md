# Powershell Prompt Theme

This is a custom prompt string designed for personal use.

![PowerShell Prompt Preview](prompt.png)

## Usage

Follow these steps to set up and use the theme:

1. **Install Fira Code Font with Unicode Icons**: It's necessary to install the Fira Code font from [Nerd Fonts](https://www.nerdfonts.com/font-downloads). This font ensures that your custom icons and symbols are rendered correctly in your PowerShell prompt.

### Powershell

1. **Define `$PROJECTS` (Optional)**: To make the prompt more compact and improve navigation within your projects, you can define an environment variable called `$PROJECTS`. Set it to the directory where you store all your projects.

2. **Move `profile.ps1` to `$PROFILE`**: Copy the `profile.ps1` file from this repository to the `$PROFILE` directory. This will load your custom prompt every time you open a PowerShell session. After copying the file, your custom PowerShell prompt theme will be active.

### Linux

1. Paste contents of `ps1.sh` into `~/.bashrc`
