module AresMUSH
  module Scenes
    class ReposeCmd
      include CommandHandler
      
      attr_accessor :all
      
      def parse_args
        self.all = cmd.switch_is?("all")
      end
          
      def handle
        if (cmd.args)
          client.emit_failure t('pose.maybe_meant_on_off')
          return
        end
        
        if (!enactor.room.repose_on?)
          client.emit_failure t('pose.repose_off')
          return
        end
        
        repose = enactor.room.repose_info
        poses = repose.poses || []
        if (!self.all)
          poses = poses[-8, 8] || poses
        end
        
        template = BorderedListTemplate.new poses.map { |p| "#{p}%R"}, t('pose.repose_list')
        client.emit template.render
      end
    end
  end
end