
+ Glynn
+ Louise
+ 13201833
+ louise.glynn@ucdconnect.ie
+ A chat app between client and server suitable for a charity like childline/samaritans
+ I made a design decision not to set the username for the app in the settings and decided to request authentication on each launch because of the private nature of my app.  I wanted the user to login with their username and password to ensure the confidentiality of the data even if the phone was stolen or used by anyone else.

The chat app was based on https://www.ibm.com/developerworks/library/x-ioschat/
However it was developed on Xcode 3 so I had to make some changes

I implemented http://alexbarinov.github.io/UIBubbleTableView/ for my chat bubbles

If I was going live with this project I would implement over SSL for security encryption of messages - which would mean using https rather than http…
I would use an NSURLSession Delegate to authenticate by responding with the username and password…..It wouldn’t have involved much change to my code - I would have just had to implement the NSURLSessionDataDelegate method to handle the authentication challenge…
I would have had to pay for SSL certificate from my hosting provider and didn’t think I really needed to go that far with this project.


I didn’t implement registration because I wouldn’t have learned anything new and I didn’t have the time.




