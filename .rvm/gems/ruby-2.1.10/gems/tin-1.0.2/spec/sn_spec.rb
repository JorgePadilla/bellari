require 'fiddle'

module Fiddle
  class Function
    attr_accessor :count

    def initialize(lib, args, ret)
      @count = 0
      @lib = lib
      @args = args
      @ret = ret
    end

    def call(*args)
      @count += 1
      raise "Wrong # of args" unless @args.size == args.size
    end
  end
end

require 'sn'

describe Sn, ".notify" do
  it "should show a notification" do
    Sn::NOTIFICATION[:new].count = 0
    Sn::NOTIFICATION[:show].count = 0
    Sn.notify "summary", "message", ""
    Sn::NOTIFICATION[:new].count.should eq(1)
    Sn::NOTIFICATION[:show].count.should eq(1)
  end
end

describe Sn::Notification, ".show" do
  it "should show a notification" do
    Sn::NOTIFICATION[:show].count = 0
    n = Sn::Notification.new "summary", "message", ""
    n.show
    Sn::NOTIFICATION[:show].count.should eq(1)
  end
end

describe Sn::Notification, ".close" do
  it "should close a notification" do
    Sn::NOTIFICATION[:close].count = 0
    n = Sn::Notification.new "summary", "message", ""
    n.show
    n.close
    Sn::NOTIFICATION[:close].count.should eq(1)
  end
end

describe Sn::Notification, ".summary=" do
  it "should update a notification's summary" do
    summary = "Stuff"
    Sn::NOTIFICATION[:update].count = 0
    n = Sn::Notification.new "summary", "message", ""
    n.summary = summary
    n.show
    Sn::NOTIFICATION[:update].count.should eq(1)
    n.summary.should eq(summary)
  end
end


describe Sn::Notification, ".message=" do
  it "should update a notification's message" do
    message = "Stuff"
    Sn::NOTIFICATION[:update].count = 0
    n = Sn::Notification.new "summary", "message", ""
    n.message = message
    n.show
    Sn::NOTIFICATION[:update].count.should eq(1)
    n.message.should eq(message)
  end
end

describe Sn::Notification, ".icon=" do
  it "should update a notification's icon" do
    icon = "refresh"
    Sn::NOTIFICATION[:update].count = 0
    n = Sn::Notification.new "summary", "message", ""
    n.icon =icon 
    n.show
    Sn::NOTIFICATION[:update].count.should eq(1)
    n.icon.should eq(icon)
  end
end

describe Sn::Notification, ".category=" do
  it "should set a notification's category" do
    category = "Category"
    Sn::NOTIFICATION[:set_category].count = 0
    n = Sn::Notification.new "summary", "message", ""
    n.category = category 
    n.show
    Sn::NOTIFICATION[:set_category].count.should eq(1)
    n.category.should eq(category)
  end
end

describe Sn::Notification, ".urgency=" do
  it "should set a notification's urgency" do
    Sn::NOTIFICATION[:set_urgency].count = 0
    n = Sn::Notification.new "summary", "message", ""
    n.urgency = :low
    n.show
    Sn::NOTIFICATION[:set_urgency].count.should eq(1)
  end

  it "should map keyword urgencies properly" do
    n = Sn::Notification.new "summary", "message", ""
    n.urgency = :low
    n.urgency.should eq(Sn::URGENCIES[:low])
    n.urgency = :normal
    n.urgency.should eq(Sn::URGENCIES[:normal])
    n.urgency = :critical
    n.urgency.should eq(Sn::URGENCIES[:critical])
  end
end

describe Sn::Notification, ".timeout=" do
  it "should set a notification's timeout" do
    Sn::NOTIFICATION[:set_timeout].count = 0
    n = Sn::Notification.new "summary", "message", ""
    n.timeout = 1023
    n.show
    Sn::NOTIFICATION[:set_timeout].count.should eq(1)
    n.timeout.should eq(1023)
  end

  it "should map keyword timeout properly" do
    n = Sn::Notification.new "summary", "message", ""
    n.timeout = :default
    n.timeout.should eq(Sn::TIMEOUTS[:default])
    n.timeout = :never
    n.timeout.should eq(Sn::TIMEOUTS[:never])
  end
end

describe Sn::Notification, ".closed_reason" do
  it "should get a notification's closing reason" do
    Sn::NOTIFICATION[:get_closed_reason].count = 0
    n = Sn::Notification.new "summary", "message", ""
    n.show
    n.close
    n.closed_reason
    Sn::NOTIFICATION[:get_closed_reason].count.should eq(1)
  end
end
