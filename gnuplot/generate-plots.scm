(import (scheme base) (scheme write) (statistics))

(define prelude
  '("#! /usr/bin/env gnuplot"
    "set terminal pngcairo size 500,500"
    "set style line 1 lc rgb '#0000ff' pt 7 ps 1.5 lt 1 lw 2"
    "unset key"))

(define echo (lambda args (for-each display args) (newline)))

(define (plot-point x y) (echo x " " y))

(define (plot-function interval step name f)
  (with-output-to-file (string-append name "-plot")
    (lambda ()
      (for-each echo prelude)
      (echo "set output '" name "-plot.png'")
      (echo "plot '" name "-data' w p ls 1")))
  (with-output-to-file (string-append name "-data")
    (lambda ()
      (let loop ((x (- interval)))
        (when (<= x interval)
          (plot-point x (f x))
          (loop (+ x step)))))))

(define normal-cdf ndtr)

(define (student-cdf v)
  (define (sign t) (if (negative? t) -1 1))
  (lambda (t)
    (let ((x (/ v (+ v (square t)))))
      (+ 0.5 (* 0.5 (sign t) (- (incbet (* 0.5 v) 0.5 1.0)
                                (incbet (* 0.5 v) 0.5 x)))))))

(plot-function 5.0 0.25 "normal-cdf" normal-cdf)
(plot-function 5.0 0.25 "student-cdf" (student-cdf 1.0))