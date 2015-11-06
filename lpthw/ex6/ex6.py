x = "There are %d types of people." % 10
binary = "binary"
do_not = "don't"
y = "Those who know %s and those who %s." %(binary, do_not)

print x # print just x
print y # print just y

print "I said: %r." %x # %r print x with single quote
print "I also said: '%s'." % y # %s print y without single quote

hilarious = False
joke_evaluation = "Isn't that joke so funny?! %r"

print joke_evaluation % hilarious # hilarious is boolean so prints without single quote

w = "This is the left side of..."
e = "a string with a right side."

print w + e # concatenate w and e