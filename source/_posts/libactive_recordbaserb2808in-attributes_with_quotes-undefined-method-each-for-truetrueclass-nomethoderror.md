Title: lib/active_record/base.rb:2808:in `attributes_with_quotes': undefined method `each' for true:TrueClass (NoMethodError)
Date: 2009-02-09 20:49:54
Tags: activerecord,issues,ruby
---
OK, hopefully this might help someone some time somewhere. If you are getting the error on the title, it's mainly because you are using a <tt>changed</tt> method on your <a href="http://api.rubyonrails.org/classes/ActiveRecord/Base.html">ActiveRecord</a> model.

I was working with an ActiveRecord model that handles an string with quotes, so when trying to save the model, that exception was raised. The problem is that ActiveRecord uses a <tt>changed</tt> method internally for all attributes that were modified. When you are using a changed method yourself, you are overwriting it, hence the error. In my case:

<tt>/opt/local/lib/ruby/gems/1.8/gems/activerecord-2.2.2/lib/active_record/base.rb:2808:in `attributes_with_quotes': undefined method `each' for true:TrueClass (NoMethodError)
from /opt/local/lib/ruby/gems/1.8/gems/activerecord-2.2.2/lib/active_record/base.rb:2706:in `update_without_lock'</tt>

Solution, just get rid of your changed method and rename it something else.

Also helpful information, <a href="http://www.ruby-forum.com/topic/173908">here</a>.