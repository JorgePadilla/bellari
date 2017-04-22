require 'fiddle'

=begin

Tin is a simple interface to libnotify using Fiddle.

== Example

    require 'sn'

    # a simple demo
    summary = 'tin demo'
    message = 'Just a quick message from tin!'
    Sn.notify(summary, message)

    # a customized demo
    notification = Sn::Notification.new(summary, message)
    notification.timeout = :never
    notification.show
    sleep 6
    notification.close

== Notes

Deprecated functions are not included in the those available through Sn.

These function are also not included:
* notify_get_server_caps
* notify_get_server_info
* notify_notification_set_hint
* notify_notification_clear_hints
* notify_notification_set_image_from_pixbuf
* notify_notification_add_action
* notify_notification_clear_actions
=end

module Sn
  include Fiddle

  # Mapping from keyword urgencies to the in values used by libnotify
  URGENCIES = {:low => 0, :normal => 1, :critical => 2}

  # Mapping from keyword timeouts to the int values libnotify uses
  TIMEOUTS = {:default => -1, :never => 0}

  # Uninitialize libnotify
  def self.stop
    @notify[:uninit].call if @notify[:is_initted].call == 1
  end

  # Setup the libnotify interface and initialize libnotify.
  def self.start(app_name)
    notify_cmd = {
        :init => {:arg => [TYPE_VOIDP], :ret => TYPE_INT},
        :uninit => {:arg => [], :ret => TYPE_INT},
        :is_initted => {:arg => [], :ret => TYPE_INT},
        :get_app_name => {:arg => [], :ret => TYPE_VOIDP},
        :set_app_name => {:arg => [TYPE_VOIDP], :ret => TYPE_VOID}
    }

    notification_cmd = {
      :new => {:arg => [TYPE_VOIDP] * 3, :ret => TYPE_VOIDP},
      :show => {:arg => [TYPE_VOIDP] * 2, :ret => TYPE_INT},
      :update => {:arg => [TYPE_VOIDP] * 4, :ret => TYPE_INT},
      :set_urgency => {:arg => [TYPE_VOIDP, TYPE_INT], :ret => TYPE_VOID},
      :close => {:arg => [TYPE_VOIDP] * 2, :ret => TYPE_INT},
      :get_closed_reason => {:arg => [TYPE_VOIDP], :ret => TYPE_INT},
      :set_app_name => {:arg => [TYPE_VOIDP] * 2, :ret => TYPE_VOID},
      :set_timeout => {:arg => [TYPE_VOIDP, TYPE_INT], :ret => TYPE_VOID},
      :set_category => {:arg => [TYPE_VOIDP] * 2, :ret => TYPE_VOID}
    }

    dl = DL.dlopen 'libnotify.so'
    
    @notify = {}
    notify_cmd.each do |k, v|
      name = "notify_#{k.to_s}"
      @notify[k] = Function.new(dl[name], v[:arg], v[:ret])
    end

    @notification = {}
    notification_cmd.each do |k, v|
      name = "notify_notification_#{k.to_s}"
      @notification[k] = Function.new(dl[name], v[:arg], v[:ret])
    end

    @app_name = app_name
    @notify[:init].call app_name # 1 or 0

    at_exit do
      Sn.stop
    end
  end

  start $0 # Run start immediatle so @notification and @app_name are available

  # Provides access to the individual Fiddle::Function objects.
  NOTIFICATION = @notification

  # The application name used to initialize libnotify
  APP_NAME = @app_name

  # Create and display a notification using (mostly) default values.
  def self.notify(summary, message="", icon="")
    n = @notification[:new].call(summary, message, icon)
    @notification[:show].call n, nil
  end

  def self.app_name
    NOTIFY[:get_app_name].call
  end

  def self.set_app_name(value=$0)
    NOTIFY[:set_app_name].call value
  end

  # This class manages an application notification.
  class Notification
    attr_reader :app_name, :category, :summary, :message, :urgency, :icon
    attr_reader :timeout

    # Mapping from keyword timeouts to the int values libnotify uses
    @@timeout_consts = TIMEOUTS

    # +summary+:: the summary line generally displayed at the top of the
    # notification
    #
    # +message+:: the message text of the notification
    # 
    # +icon+:: a theme name or file path for an icon to display with the
    # notification (if this is supported?)
    def initialize(summary, message="", icon="")
      @summary = summary
      @message = message
      @icon = icon
      @urgency = :normal
      @category = ""
      @app_name = APP_NAME
      @notification = NOTIFICATION[:new].call summary, message, icon
    end
    
    # Send the notification to the system
    def show
      NOTIFICATION[:show].call @notification, nil
    end
    
    # Close this notification.
    def close
      NOTIFICATION[:close].call @notification, nil
    end

    # Obtain the reason that this notification was closed.
    def closed_reason
      NOTIFICATION[:get_closed_reason].call @notification
    end

    # Register changed summary, body, and icon values.
    # Each time any of these fields are assigned, they will be updated by
    # calling this method automatically.  Generally, it should not be necessary
    # to call this method explicitly.
    def update
      NOTIFICATION[:update].call @notification, @summary, @body, @icon
    end

    def summary=(value)
      @summary = value
      update
    end

    def message=(value)
      @message = value
      update
    end

    def icon=(value)
      @icon = value
      update
    end

    def category=(value)
      @category = value
      NOTIFICATION[:set_category].call @notification, @category
    end

    # Set the timeout that controls when the notification will be closed.  The
    # timeout can be specified as a number of milliseconds or using the keywords
    # +:default+ or +:never+.
    def timeout=(timeout=:default)
      @timeout = TIMEOUTS.member?(timeout) ? TIMEOUTS[timeout] : timeout
      NOTIFICATION[:set_timeout].call @notification, @timeout
    end

    def urgency=(value)
      @urgency = URGENCIES[value]
      NOTIFICATION[:set_urgency].call @notification, URGENCIES[@urgency]
    end
  end
end

