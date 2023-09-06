# ---------------------------------------------------------------------
# Kernel Configuration
#---------------------------------------------------------------------

{
  # ---------------------------------------------------------------------
  # SysRQ for is rebooting their machine properly if it freezes
  # SOURCE: https://oglo.dev/tutorials/sysrq/index.html
  #---------------------------------------------------------------------

 # boot.kernel.sysctl."kernel.sysrq" = 1;

  # ---------------------------------------------------------------------
  # reduce unnecessary swapping of data between RAM and disk
  # ---------------------------------------------------------------------

 # boot.kernel.sysctl."vm.swappiness" = 10;

}
