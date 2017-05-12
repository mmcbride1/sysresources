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

      # print info #
      $CPU = "current cpu usage: "
      $DSK = "remaining disk: "
      $RAM = "memory available: "
      $PRC = "running processes: "
      $UPT = "system uptime: "

      # stats header #
      $header = "current".light_blue     
      $root   = "/home"
      $error  = " no info!".red
      $disk   = Sys::Filesystem

      # color stat #
      def stat(stat)
        stat = stat.to_s
        stat.yellow
      end

      # color name #    
      def name(name)
        name = name.to_s
        name.white    
      end

      # get disk stats #
      def get_disk
        multi = 1024
        dirc = File.exist?($root) ? $root : "/"
        root = $disk.stat(dirc)
        size = root.block_size
        avil = root.blocks_available
        gb = size * avil /multi/multi/multi
        stat("#{gb}G")
        rescue    
          $error
      end

      # get memory stats #
      def get_ram
        cmd = %x(free -h)
        free = cmd.split(" ")[9]
        stat(free) 
        rescue    
          $error
      end

      # get cpu cores #
      def cores 
        raw =  Sys::CPU.processors
        cnt = raw[0]['cpu_cores']
        return cnt.to_i
      end

      # get cpu load #
      def get_load
        info = Sys::CPU.load_avg
        load = info.join(", ")
        stat(load)
        rescue    
          $error
      end

      # get cpu percent #
      def get_cpu
        cmd = %x(ps -eo "%C").split("\n")
        sum = cmd.map(&:to_f).reduce(0,:+)
        cpu = (sum/cores).round(2)
        stat(cpu) + "%"
        rescue    
          $error
      end

      # get uptime #
      def get_upt
        cmd = %x(uptime)   
        upt = cmd.split(",")[0]
        upt = upt.split("up")[1]
        stat(upt.strip())
        rescue    
          $error
      end

      # get running processes #    
      def get_proc
        proc = %x(ps -A --no-headers | wc -l)
        stat(proc)
        rescue    
          $error
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

      # prints cpu stat #
      def print_cpu
        puts name($CPU) +
        get_cpu
      end

      # prints disk stat #
      def print_disk
        puts name($DSK) +
        get_disk.to_s
      end
      
      # prints ram stat #
      def print_ram
        puts name($RAM) +
        get_ram
      end

      # print upt stat #
      def print_upt
        puts name($UPT) +
        get_upt
      end

      # prints proc stat #
      def print_proc
        puts name($PRC) +
        get_proc.delete("\n")
      end
   
      # print stats #
      def run_stats     
        header
        get_stat  
        exit(0) 
      end
   end
end
