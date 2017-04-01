#######################
# collects system     #
# resource statisitcs #
# 03/22/2017          #
#######################

require 'vmstat'
require 'sys-cpu'
require 'colorize'
require 'sys/filesystem'
require 'sysresources/version'

module Sysresources     

   class SysResource    

      # stats header #
      $header = "current".light_blue     
      $disk   = Sys::Filesystem

      # color stat #
      def stat(stat)
        stat = stat.to_s
        return stat.yellow
      end

      # color name #    
      def name(name)
        name = name.to_s
        return name.white    
      end

      # get disk stats #
      def get_disk
        multi = 1024
        root = $disk.stat("/home")
        size = root.block_size
        avil = root.blocks_available
        gb = size * avil /multi/multi/multi
        return stat("#{gb}G")
      end

      # get memory stats #
      def get_ram
        cmd = %x(free -h)
        free = cmd.split(" ")[9]
        return stat(free) 
      end

      # get cpu cores #
      def cores 
        raw =  Sys::CPU.processors
        cnt = raw[0]['cpu_coresn']
        return cnt.to_i
      end

      # get cpu load #
      def get_load
        info = Sys::CPU.load_avg
        load = info.join(", ")
        return stat(load)
      end

      # get cpu percent #
      def get_cpu
        cmd = %x(ps -eo "%C").split("\n")
        sum = cmd.map(&:to_f).reduce(0,:+)
        cpu = (sum/cores).round(2)
        return stat(cpu) + "%"
      end

      # get uptime #
      def get_upt
        cmd = %x(uptime)   
        upt = cmd.split(",")[0]
        upt = upt.split("up")[1]
        return stat(upt.strip())
      end

      # get running processes #    
      def get_proc
        proc = %x(ps -A --no-headers | wc -l)
        return stat(proc)
      end

      # get header #
      def header
        host = %x(hostname).strip()
        end_ = "\n\n"
        for_ = "[ #{host} #{$header} ]"
        puts "\n"+for_+end_
      end

      # get stats #
      def get_stat
        fromsys = {
          "disk:"    => get_disk, 
          "ram:"     => get_ram, 
          "cpu:"     => get_cpu, 
          "uptime:"  => get_upt, 
          "process:" => get_proc
        }
        fromsys.each do |k,v|
          puts " xxxxxxxxx #{name(k)}"+"#{v}"
        end
      end

      # print stats #
      def run_stats     
        header
        get_stat   
      end
   end
end
