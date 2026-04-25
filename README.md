----------- ![Discord](https://img.shields.io/badge/Discord-%407umz-7289da?style=for-the-badge&logo=discord&logoColor=white) -----------

# 🌌 Minimalist High-End Terminal Setup

> A beautiful, curated terminal experience featuring **Kitty**, **Fastfetch**, and **Fish Shell**. Designed for GNOME-based Linux distributions but compatible with almost any modern Linux environment.

---

## ✨ Preview
![Terminal Preview](preview_terminal.png)

---

## 🚀 Quick Start

Follow these steps to transform your terminal into a high-end workspace.

### 1. Install the Essentials
To get the full look, including the custom ASCII art and the prompt, you need to install the dependencies:

# For Fedora
`sudo dnf install kitty fastfetch fish figlet cmatrix hollywood`

**Important:** This setup uses **Starship** for the prompt. Install it with:
`curl -sS https://starship.rs/install.sh | sh`

### 2\. Set Fish as Default

Switch from the standard Bash to the powerful Fish shell:

`chsh -s $(which fish)`

*(Note: You may need to log out and back in for this to take effect.)*

### 3\. Apply the Configuration

Move my configuration files into your local directory:

1.  Clone this repository.
2.  Navigate to your `~/.config` folder.
3.  Replace the `fish`, `kitty`, and `fastfetch` folders with the ones from this repo.

<!-- end list -->


# Quick command to move them (if you are in the cloned repo folder)

`cp -r fish kitty fastfetch ~/.config/`

-----

## 🛠️ Custom Functions Toolkit

| Command | Action | Why use it? |
| :--- | :--- | :--- |
| **`l`** | Smart Directory Analysis | Premium replacement for `ls` featuring iconography and metadata visualization. |
| **`matrix`** | Digital Rain Protocol | Initiates the classic green phosphor cascade visual effect. |
| **`hollywood`** | Cinematic Interface | Orchestrates a multi-pane "Technologist" aesthetic for workspace visualization. |
| **`clean`** | Buffer Sanitization | Executes a deep terminal reset to eliminate scrollback artifacts. |
| **`cat`** | Professional Syntax Viewer | High-fidelity file inspection with integrated syntax highlighting and line indexing. |
| **`getdata`** | Data Analysis Engine | Provisions the virtual environment architecture for advanced data modeling. |
| **`stayawake`** | Sentinel Prime | **Overrides lid-suspend and security-lock.** Features a high-availability dashboard. |
| **`cleanreset`** | **Infrastructure Restoration** | **Nukes system overrides and clear cache Fedora factory defaults.** |
| **`testdrive`** | Core Stress Analytics | Validates system stability through thermal monitoring and high-load core saturation. |
| **`mkgif`** | Media Conversion | Optimized pipeline for transforming video assets into high-quality GIF formats. |

---

#### 🌀 `stayawake` (Sentinel Prime: Signature Edition)
An advanced system inhibitor created to bypass the standard Linux lid-suspend and screen-lock protocols. Features a real-time HUD showing CPU, RAM, Battery, and Audio/Mic status, along with a 24-hour progress bar and dynamic "Session Ranks" from Alpha to Skibidi God.

#### 🏎️ `testdrive`
A high-performance utility designed to push system hardware to the limit while maintaining a clean, terminal-based visual interface. Perfect for verifying stability after a fresh build or heavy configuration changes.


-----


## 👤 Personalize Your Name
The terminal greeting shows **"eprahemi"** in rainbow ASCII art. To change this to your own name:

1. Open the configuration file:
   
   `sudo nano ~/.config/fish/functions/fish_greeting.fish`
   
3. Change the word inside the quotes to your name:
   
   # Change "eprahemi" to "yourname"
   function fish_greeting
       figlet "yourname" | lolcat
   end
   
5. Save and restart your terminal!

---

## 📦 Extra Dependencies
For the greeting and effects to work, make sure you have these installed:

# Fedora

`sudo dnf install figlet lolcat cmatrix hollywood`

-----

## ✨ Desktop Aesthetics


## ✨ Preview
![Desktop Preview](preview_desktop.png)


  * **GTK Theme:** [MacTahoe](https://github.com/vinceliuice/WhiteSur-gtk-theme)
  * **Icons:** MacTahoe Icons
  * **Wallpaper:** Available in My Secret Wallpapers Repository +18.

-----

**GitHub:** [@xmyhead3](https://www.google.com/search?q=https://github.com/xmyhead3)  
**Discord:** `@7umz`
