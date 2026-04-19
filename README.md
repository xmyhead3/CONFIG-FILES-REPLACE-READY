Markdown
# 🌌 Minimalist High-End Terminal Setup

> A beautiful, curated terminal experience featuring **Kitty**, **Fastfetch**, and **Fish Shell**. Designed for GNOME-based Linux distributions but compatible with almost any modern Linux environment.

---

## ✨ Preview
![Terminal Preview](preview_terminal.png)

---

## 🚀 Quick Start

Follow these steps to transform your terminal into a high-end workspace.

### 1. Install the Essentials
First, ensure you have the necessary tools installed on your system:
# Example for Fedora
`sudo dnf install kitty fastfetch fish`

### 2. Set Fish as Default
Switch from the standard Bash to the powerful Fish shell:

chsh -s $(which fish)
(Note: You may need to log out and back in for this to take effect.)

### 3. Apply the Configuration
Move my configuration files into your local directory:

Clone this repository.

Navigate to your `~/.config` folder.

Replace (or add) the fish, kitty, and fastfetch folders with the ones from this repo.

# Quick command to move them (if you are in the cloned repo folder)
`cp -r fish kitty fastfetch ~/.config`



## 🛠️ Custom "Power-User" 
ToolkitI’ve built a collection of custom Fish functions that turn your terminal into a high-end workstation. These aren't just aliases; they are full scripts located in the fish/functions/ folder.


| cat : Custom Viewer,A customized way to view file contents beautifully. |
| clean : Deep Clear,Resets the terminal buffer for a truly fresh start. |
| fish_greeting : The Welcome,Displays the custom ASCII name and system info. |
| hollywood : Movie Mode,"Splits terminal into ""hacker"" panes for the aesthetic." |
| l : Smart List,My high-end replacement for ls with icons and details. |
| matrix : The Matrix,Drops you into the green digital rain effect. |
| p : Quick Jump,A fast shortcut to jump to your important project paths. |

# To feel like you're in a movie:
hollywood
Note: For matrix and hollywood to work, ensure you have the base packages installed:
`sudo dnf install cmatrix hollywood` (Fedora)



## ✨ Preview
![Desktop Preview](preview_desktop.png)


I am using Mactahoe Gtk Theme and his icons as well if you asked
