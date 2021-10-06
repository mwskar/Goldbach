#!/usr/bin/sbcl --script


(defun genPrimes (maxValue)
    (let (
        (primeList '())
        )

        (do
            (  (num 1 (+ 2 num))  ) ;variables
            (  (> num maxValue)  (= num maxValue)) ; exit
            ( 
                if (isPrime num) (setq primeList (append primeList (list num))) 
            ) ;do
        ) ; end of do

        (return-from genPrimes primeList)
    ); end let
); end func genPrimes

(defun isPrime (num)
    (do
        ( (counter 3 (+ 2 counter)) );variables
        ( (> (* counter counter) num) );end
        (  if (= 0 (mod num counter )) (return-from isPrime nil)  );do
    ) ; end of do

    (return-from isPrime t)
)

(defun calcGoldbach (primeList userInput)
    (let (
        (norm 0)
        (newNorm 0)
        (i 0)
        (k 0)
        (j 0)
        (len (length primeList))
        (revList (reverse primeList))
        (answer '(0 0 0))
        )
    

        ;(print "Before loops")
        (loop for k_pos from 0 to (* 2 (/ len 3))
            do (setq k (nth k_pos revList))
            ;(print "inside first loop")
            (loop for j_pos from (+ k_pos 1) to (- len 2)
                do
                (setq j (nth j_pos revList))
                (setq i (- userInput (+ k j)))
                ;(print "inside second loop")
                (setq newNorm (calcNorm i j k))

                (format t "~d ~d ~d | ~F ~%" i j k newNorm)

                (when (and (< i j) (isPrime i))
                    (when (and (= norm newNorm) (> i (car answer)))
                               (setq norm newNorm)
                               (setq answer (list i j k))
                    ); end when

                    (when (or (= 0 norm) (< newNorm norm))
                            (setq norm newNorm)
                            (setq answer (list i j k))
                    );end when

                );end when    
            ); end inner loop
        ); end outer loop
     
        (return-from calcGoldbach answer)
    );end temp declariation zone
) ;end fun calcGoldbach


(defun calcNorm (i j k)
    (return-from calcNorm (sqrt ( + (* i i) (+ (* j j) (* k k) ) ))  )
)


(defvar userInput)
(print "Please enter an odd number greater than 7: ")
(terpri)
(setq userInput (read) )
(terpri)

(defvar primeList '())
(defvar answer '())




(setq primeList (genPrimes userInput))
(setq answer (calcGoldbach primeList userInput))


(print primeList)
(print answer)
(terpri)
