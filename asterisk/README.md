# asterisk

Configuration for the [Asterisk](https://www.asterisk.org) phone system (PBX):
`sip.conf` / `pjsip.conf` (SIP accounts), `extensions.conf` / `extensions.ael` (dial plan),
`voicemail.conf`, `manager.conf` (AMI).

**Not stowed.** These belong in `/etc/asterisk/`; copy them by hand on a machine that runs Asterisk:

```bash
sudo cp ~/dotfiles/asterisk/*.conf ~/dotfiles/asterisk/*.ael /etc/asterisk/
sudo systemctl restart asterisk
```

Check the files for passwords before pushing this repo anywhere public.
