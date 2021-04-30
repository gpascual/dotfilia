function conky_net_ifaces()
  local file = io.popen("find /sys/class/net/ -type l -printf \"%f\n\" | sort")

  local ifaces = "NET\n"
  for iface in file:lines()
    do  ifaces= ifaces.."${if_up "..iface.."}${voffset 8}${color2}${goto 12}"..iface.."${color}\n${goto 12}${color1}Down${goto 70}$color${downspeed "..iface.."}${goto 172}${color1}Up${goto 210}$color${upspeed "..iface.."}\n${endif}"
  end

  file:close()
  return ifaces
end

