tin
===

* (https://github.com/gamma9mu/tin)

DESCRIPTION:
------------

tin provides a simple interface to libnotify.

FEATURES/PROBLEMS:
------------------

* Simple, one method notifications
* Notification class for more complicated needs
* Includes most (non-deprecated) libnotify features


SYNOPSIS:
---------

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


REQUIREMENTS:
-------------

* Ruby 1.9
* libnotify (tested with version 0.7.5)

INSTALL:
--------

* gem install tin

DEVELOPERS:
-----------

There is nothing special to know...

LICENSE:
--------

(The BSD New License)

Copyright (c) 2012 Brian A. Guthrie
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright notice,
      this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright notice,
      this list of conditions and the following disclaimer in the documentation
      and/or other materials provided with the distribution.
    * Neither the name of the copyright holder nor the names of its
      contributors may be used to endorse or promote products derived from this
      software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
