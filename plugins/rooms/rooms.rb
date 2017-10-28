$:.unshift File.dirname(__FILE__)
load "engine/commands/area_cmd.rb"
load "engine/commands/build_cmd.rb"
load "engine/commands/foyer_cmd.rb"
load "engine/commands/go_cmd.rb"
load "engine/commands/grid_cmd.rb"
load "engine/commands/home_cmd.rb"
load "engine/commands/home_set_cmd.rb"
load "engine/commands/ic_start_cmd.rb"
load "engine/commands/link_cmd.rb"
load "engine/commands/lock_cmd.rb"
load "engine/commands/lock_here_cmd.rb"
load "engine/commands/meetme_go_cmd.rb"
load "engine/commands/meetme_invite_cmd.rb"
load "engine/commands/open_cmd.rb"
load "engine/commands/out_cmd.rb"
load "engine/commands/owner_cmd.rb"
load "engine/commands/rooms_cmd.rb"
load "engine/commands/roomtype_cmd.rb"
load "engine/commands/teleport_cmd.rb"
load "engine/commands/unlink_cmd.rb"
load "engine/commands/unlock_here_cmd.rb"
load "engine/commands/work_cmd.rb"
load "engine/commands/work_set_cmd.rb"
load "engine/char_connected_event_handler.rb"
load "engine/char_disconnected_event_handler.rb"
load "engine/cron_event_handler.rb"
load "lib/helpers.rb"
load "lib/room_model.rb"
load "lib/rooms_api.rb"
load "web/locations.rb"

module AresMUSH
  module Rooms
    def self.plugin_dir
      File.dirname(__FILE__)
    end
 
    def self.shortcuts
      Global.read_config("rooms", "shortcuts")
    end
 
    def self.load_plugin
      self
    end
 
    def self.unload_plugin
    end
    
    def self.config_files
      [ "config_rooms.yml" ]
    end
 
    def self.locale_files
      [ "locales/locale_en.yml" ]
    end
 
    def self.get_cmd_handler(client, cmd, enactor)
      case cmd.root
      when "area"
        return AreaCmd
      when "build"
        return BuildCmd
      when "foyer"
        return FoyerCmd
      when "go"
        return GoCmd
      when "grid"
        return GridCmd
      when "home"
        case cmd.switch
        when "set"
          return HomeSetCmd
        when nil
          return HomeCmd
        end
      when "icstart"
        return ICStartCmd
      when "link"
        return LinkCmd
      when "lock"
        if (cmd.args)
          return LockCmd
        else
          return LockHereCmd
        end
      when "meetme"
        case cmd.switch
        when "join", "bring"
          return MeetmeGoCmd
        when nil
          return MeetmeInviteCmd
        end
      when "open"
        return OpenCmd
      when "out"
        return OutCmd
      when "owner"
        return OwnerCmd
      when "rooms"
        return RoomsCmd
      when "roomtype"
        return RoomTypeCmd
      when "teleport"
        return TeleportCmd
      when "unlink"
        return UnlinkCmd
      when "unlock"
        if (cmd.args)
          return LockCmd
        else
          return UnlockHereCmd
        end
      when "work"
        case cmd.switch
        when "set"
          return WorkSetCmd
        when nil
          return WorkCmd
        end
      end
      
      nil
    end
    
    def self.get_event_handler(event_name) 
      case event_name
      when "CharConnectedEvent"
        return CharConnectedEventHandler
      when "CharDisconnectedEvent"
        return CharDisconnectedEventHandler
      when "CronEvent"
        return CronEventHandler
      end
      nil
    end
  end
end