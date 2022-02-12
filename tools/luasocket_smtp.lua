-- luasocket smtp mail send for scorekeeping and marketing efforts
-- from: https://love2d.org/forums/viewtopic.php?t=77185
function love.load()

local smtp = require("socket.smtp")

mesgt = {
  headers = {
    to = "<exampleTo@mail.com>",
    subject = "Topic name"
  },
  body = "Mail text ..."
}

r, e = smtp.send{
  from = "<exampleFrom@mail.com>",
  rcpt = "<exampleTo@mail.com>", 
  source = smtp.message(mesgt),
  user = "exampleFrom",                                                                           
  password = "password",												--\ password to exampleFrom@mail.com
  server = "smtp.mail.com",											--\ example: "smtp.gmail.com"
  port = 587--,														--\ 587 or 25
--   domain = string,
--   step = LTN12 pump step,
--   create = function  
}
	
print(r)
print(e)	
	
end