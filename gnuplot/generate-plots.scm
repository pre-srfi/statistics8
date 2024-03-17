(import (scheme base) (scheme write) (statistics))

(define prelude
  '("#! /usr/bin/env gnuplot"
    "unset key"
    "set grid"
    "set style line 1 lc rgb '#0000ff' pt 7 ps 1.5 lt 1 lw 2"
    "set style line 2 lc rgb '#00ff00' pt 7 ps 1.5 lt 1 lw 2"
    "set style line 3 lc rgb '#ff0000' pt 7 ps 1.5 lt 1 lw 2"
    "set terminal pngcairo size 500,500"))

(define echo (lambda args (for-each display args) (newline)))

(define (plot-point x y) (echo x " " y))

(define (plot-function-data xmin xmax step data-file f)
  (with-output-to-file data-file
    (lambda ()
      (let loop ((x (inexact xmin)))
        (when (<= x xmax)
          (plot-point x (f x))
          (loop (+ x step)))))))

(define (plot-function xmin xmax step name f c1 c2 c3)
  (define (data-file i) (string-append name "-data-" (number->string i)))
  (with-output-to-file (string-append name "-plot")
    (lambda ()
      (for-each echo prelude)
      (echo "set output '" name "-plot.png'")
      (echo "plot '" (data-file 1) "' w p ls 1" ", \\")
      (echo "     '" (data-file 2) "' w p ls 2" ", \\")
      (echo "     '" (data-file 3) "' w p ls 3")))
  (plot-function-data xmin xmax step (data-file 1) (f c1))
  (plot-function-data xmin xmax step (data-file 2) (f c2))
  (plot-function-data xmin xmax step (data-file 3) (f c3)))

(define (normal-cdf sigma-squared)
  (let ((sigma (sqrt sigma-squared)))
    (lambda (x) (ndtr (/ x  sigma)))))

(define (student-cdf v)
  (lambda (t)
    (let ((x (/ v (+ v (square t))))
          (h (if (negative? t) -0.5 0.5)))
      (+ 0.5 (* h (- (incbet (* 0.5 v) 0.5 1.0)
                     (incbet (* 0.5 v) 0.5 x)))))))

(define (chi-squared-cdf k)
  (lambda (x) (igam (* 0.5 k) (* 0.5 x))))

(plot-function 0 8 0.25 "chi-squared-cdf" chi-squared-cdf 1.0 4.0 9.0)
(plot-function -5 5 0.25 "normal-cdf" normal-cdf 0.2 1.0 5.0)
(plot-function -5 5 0.25 "student-cdf" student-cdf 1.0 2.0 5.0)
