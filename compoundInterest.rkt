#|Name: Edison Cai
ID Number: 20241135

My code aims to print out the results of compound interest on money and prints an ERROR warning for inappropriate values.
For example, this code would be useful for someone looking to analyse their investment strategy.|#

#lang racket

;Sample Data in the form (initialInvestment rateOfGrowth years). Bad data is also present.
(define investments '((100 0.2 10) (2500 0.5 5)(1 0 19)(2 1 1.2)(1500 0.5 1)(1421 34 -142)("Hello there" #t #t)))

;Function that calculates the effect of compound interest
(define compoundInterest
  (lambda(initialValue rate years)
    ;If years = 0, return the initial value since no interest has been accrued
    (if (= 0 years)
            initialValue
            ;Otherwise, start the recursive call
            (*(compoundInterest initialValue rate (- years 1)) (+ rate 1))
       )))

;Printing the result for an investment
(define printResult
  (lambda(initialValue rate years)
    ;Throwing an error message if user inputs an inappropriate value such as
    ;negative values and values of other variable types
        (if (or(not(number? initialValue))(not(number? rate))(not(integer? years))(< initialValue 0)(< years 0))
        (display "ERROR - Sorry, only positives numbers are allowed for the initialValues and years variables. The years variable also only accepts integers.\n")
        ;Otherwise, apply the compound interest function
        (begin
          (display initialValue)
          ;Branching for 1 euro
          (if (= 1 (compoundInterest initialValue rate years))
              (display " euro invested for ")
              (display " euros invested for ")
              )
          (display years)
          ;Branching for singular and plural years
          (if (= 1 years)
              (display " year at a rate of ")
              (display " years at a rate of ")
              )
          ;Converting to percentage
          (display (* 100 rate))
          (display "% per year will return: ")
          (display (compoundInterest initialValue rate years))
          ;Branching for 1 euro
          (if (= 1 (compoundInterest initialValue rate years))
              (display " euro.\n")
              (display " euros.\n")
              )))))

;Applies printResult function to a single set of initial investment, rate, years
(define process(lambda(x)(apply printResult x)))

;Making a run function so you don't have to type in for-each compoundInterest every time
;Using for-each instead of map because we only need to print the results. We don't need a returned list full of voids.
(define run(lambda(list)(for-each process list)))