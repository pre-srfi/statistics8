(define-library (statistics)
  (export incbet incbi igam igamc igami ndtr ndtri jv)
  (import (gambit))
  (begin

    (c-declare "extern double incbet(double, double, double);")
    (c-declare "extern double incbi(double, double, double);")

    (c-declare "extern double igam(double, double);")
    (c-declare "extern double igamc(double, double);")
    (c-declare "extern double igami(double, double);")

    (c-declare "extern double ndtr(double);")
    (c-declare "extern double ndtri(double);")

    (c-declare "extern double jv(double, double);")

    ;;

    (define incbet
      (c-lambda (double double double) double "incbet"))

    (define incbi
      (c-lambda (double double double) double "incbi"))

    ;;

    (define igam
      (c-lambda (double double) double "igam"))

    (define igamc
      (c-lambda (double double) double "igamc"))

    (define igami
      (c-lambda (double double) double "igami"))

    ;;

    (define ndtr
      (c-lambda (double) double "ndtr"))

    (define ndtri
      (c-lambda (double) double "ndtri"))

    ;;

    (define jv
      (c-lambda (double double) double "jv"))))
