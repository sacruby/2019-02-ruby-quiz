= Ruby Quiz: Checking Credit Cards

== Background

Before a credit card is submitted to a financial institution, it generally makes sense to run some simple reality checks on the number. The numbers are a good length and it's common to make minor transcription errors when the card is not scanned directly.

The first check people often do is to validate that the card matches a known pattern from one of the accepted card providers. Some of these patterns are:

```
+============+=============+===============+
| Card Type  | Begins With | Number Length |
+============+=============+===============+
| AMEX       | 34 or 37    | 15            |
+------------+-------------+---------------+
| Discover   | 6011        | 16            |
+------------+-------------+---------------+
| MasterCard | 51-55       | 16            |
+------------+-------------+---------------+
| Visa       | 4           | 13 or 16      |
+------------+-------------+---------------+
```

All of these card types also generate numbers such that they can be validated by the Luhn algorithm, so that's the second check systems usually try. The steps are:

1. Starting with the next to last digit and continuing with every other
   digit going back to the beginning of the card, double the digit
2. Sum all doubled and untouched digits in the number
3. If that total is a multiple of 10, the number is valid

For example, given the card number 4408 0412 3456 7893:

```
Step 1:  8 4 0 8 0 4 2 2 6 4 10 6 14 8 18 3
Step 2:  8+4+0+8+0+4+2+2+6+4+1+0+6+1+4+8+1+8+3 = 70
Step 3:  70 % 10 == 0
```

Thus that card is valid.

Let's try one more, 4417 1234 5678 9112:

```
Step 1:  8 4 2 7 2 2 6 4 10 6 14 8 18 1 2 2
Step 2:  8+4+2+7+2+2+6+4+1+0+6+1+4+8+1+8+1+2+2 = 69
Step 3:  69 % 10 != 0
```

That card is not valid.

During this month's meetup, let's write programs that do credit card validation.

1. Write a command line program that accepts the credit card number as an argument:

```
$ ruby cc-validate.rb 4408 0412 3456 7893
Valid
$ ruby cc-validate.rb 4417 1234 5678 9112
Invalid
$ ruby cc-validate.rb 4408041234567893
Valid
```

2. Given a card type id (1: AMEX, 2: Discover, 3: MasterCard, 4: Visa), write a program that will generate a valid random credit card number for that type:

```
$ ruby cc-generate.rb 4
4408 0412 3456 7893
$ ruby cc-validate.rb `ruby cc-generate.rb 2`
Valid
```

3. Write an HTTP server program that will accept a valid credit card number path and return 200 if valid and 400 if not valid:

```
$ curl -s -o /dev/null -w "%{http_code}\\n" http://localhost:8080/4408041234567893
200
$ curl -s -o /dev/null -w "%{http_code}\\n" http://localhost:8080/4417123456789112
400
```

4. Write a command line HTTP client for that HTTP server that can be run from the command line and uses exit status 0 if valid and 1 if not:

```
$ if ruby cc-check.rb http://localhost:8080 4408 0412 3456 7893; then echo Valid; else echo Invalid; fi
Valid
$ if ruby cc-check.rb http://localhost:8080 4417 1234 5678 9112; then echo Valid; else echo Invalid; fi
Invalid
```
