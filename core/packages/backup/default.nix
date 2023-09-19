{ pkgs, ... }: {

  # Deduplicating archiver with compression and encryption software

  environment.systemPackages = [

    pkgs.borgbackup # borgfs, borg    Deduplicating archiver with compression and encryption
    pkgs.restic     # restic          A backup program that is fast, efficient and secure       https://www.youtube.com/watch?v=MzJbSf7GQ1E
    pkgs.restique   # restique        Restic GUI for Desktop/Laptop Backups

  ];

}
