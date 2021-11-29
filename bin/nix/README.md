# Nix install / uninstall instructions


# Nix on macOS Catalina

I'm writing this gist for my own records but it might help someone else too.


## Installing Nix

Support for Catalina has improved a lot since the update was first rolled out.

***Note:** See [the NixOS manual](https://nixos.org/manual/nix/stable/#sect-macos-installation) for discussion of the `--darwin-use-unencrypted-nix-store-volume` option.*

### Single-users

1) Run

    ```bash
    sh <(curl -L https://nixos.org/nix/install) --darwin-use-unencrypted-nix-store-volume --no-daemon
    ```

### Multi-user

1) Run

    ```bash
    sh <(curl -L https://nixos.org/nix/install) --darwin-use-unencrypted-nix-store-volume --daemon
    ```

## Uninstalling Nix

### Single-user

1) Remove the mount from `/etc/fstab` by running

    ```bash
    sudo vifs
    ```

    and deleting the  line `LABEL=Nix\040Store /nix apfs rw,nobrowse`.

2) Delete the APFS volume using `diskutil`

    ```bash
    diskutil apfs deleteVolume <volumeDevice>
    ```

***Note:** `volumeDevice` can be found by running*

```bash
diskutil apfs list
```

3) Remove the synthetic empty directory for mounting at `/nix` by running

    ```bash
    sudo vim /etc/synthetic.conf
    ```

    and deleting the line `nix`.

4) Reboot the system for changes to take effect.

5) Run

    ```bash
    echo "removing nix files"
    sudo rm -rf /nix
    rm -rf ~/.nix-profile
    rm -rf ~/.nix-defexpr
    rm -rf ~/.nix-channels
    rm -rf ~/.nixpkgs
    rm -rf ~/.config/nixpkgs
    rm -rf ~/.cache/nix
    ```

    to remove all remaining `Nix` artifacts from the system.

***Note:** There may also be references to `Nix` in the shell configurations files under your home directory (e.g. `~/.profile`, `~/.bash_profile`, `~/.zshenv`, etc.) which you may remove.*

### Multi-user

1) Kill the daemon process by running

    ```bash
    sudo launchctl unload /Library/LaunchDaemons/org.nixos.nix-daemon.plist
    ```

2) Remove the mount from `/etc/fstab` by running

    ```bash
    sudo vifs
    ```

    and deleting the  line `LABEL=Nix\040Store /nix apfs rw,nobrowse`.

3) Delete the APFS volume using `diskutil`

    ```bash
    diskutil apfs deleteVolume <volumeDevice>
    ```

***Note:** `volumeDevice` can be found by running*

```bash
diskutil apfs list
```

4) Remove the synthetic empty directory for mounting at `/nix` by running

    ```bash
    sudo vim /etc/synthetic.conf
    ```

    and deleting the line `nix`.

5) Reboot the system for changes to take effect.

6) Run

    ```bash
    echo "removing daemon"
    sudo rm /Library/LaunchDaemons/org.nixos.nix-daemon.plist

    echo "removing daemon created users and groups"
    USERS=$(sudo dscl . list /Users | grep nixbld)

    for USER in $USERS; do
        sudo /usr/bin/dscl . -delete "/Users/$USER"
        sudo /usr/bin/dscl . -delete /Groups/staff GroupMembership $USER;
    done

    sudo /usr/bin/dscl . -delete "/Groups/nixbld"

    echo "reverting system shell configurations"
    sudo mv /etc/profile.backup-before-nix /etc/profile
    sudo mv /etc/bashrc.backup-before-nix /etc/bashrc
    sudo mv /etc/zshrc.backup-before-nix /etc/zshrc

    echo "removing nix files"
    sudo rm -rf /nix
    sudo rm -rf /etc/nix
    sudo rm -rf /etc/profile/nix.sh
    sudo rm -rf /var/root/.nix-profile
    sudo rm -rf /var/root/.nix-defexpr
    sudo rm -rf /var/root/.nix-channels
    sudo rm -rf /var/root/.cache/nix
    rm -rf ~/.nix-profile
    rm -rf ~/.nix-defexpr
    rm -rf ~/.nix-channels
    rm -rf ~/.nixpkgs
    rm -rf ~/.config/nixpkgs
    rm -rf ~/.cache/nix
    ```

    to remove all remaining `Nix` artifacts from the system.
