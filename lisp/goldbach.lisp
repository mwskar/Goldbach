#!/usr/bin/sbcl --script

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;          Functions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;Genterates all odd numebrs up to the user's input (evens will never be prime)
;;The prime numbers are kept and returned
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


;;Determines if a number is prime by checking possibile dividers
;;It is assumed than an even number is not input
(defun isPrime (num)
    (do
        ( (counter 3 (+ 2 counter)) );variables
        ( (> (* counter counter) num) );end
        (  if (= 0 (mod num counter )) (return-from isPrime nil)  );do
    ) ; end of do

    (return-from isPrime t)
)

;;Tests the Goldbach conjecture by iterating through possible prime combinations
;;The answer vector will have the highest 'i' value associated with the lowest 'norm'
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
    

        ;Iterate backward starting from the end of the list to the begining third
        (loop for k_pos from 0 to (* 2 (/ len 3))
            do (setq k (nth k_pos revList))
            
            ;;Iterate backward from before k_pos to the second position
            (loop for j_pos from (+ k_pos 1) to (- len 2)
                do
                (setq j (nth j_pos revList))
                (setq i (- userInput (+ k j)))
                (setq newNorm (calcNorm i j k))


                ;Updates norm and answer vector
                (when (and (> i 0) (and (< i j) (isPrime i)))
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


;Calculates the vector norm of three numbers (v = sqrt(i^2 + J^2 + k^2))
(defun calcNorm (i j k)
    (return-from calcNorm (sqrt ( + (* i i) (+ (* j j) (* k k) ) ))  )
)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;           Main
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defvar userInput)
(print "Please enter an odd number greater than 7: ")
(terpri)
(setq userInput (read) )
(terpri)

(when (and (> userInput 7) (/= (mod userInput 2) 0))
    (defvar primeList '())
    (defvar answer '())


    (setq primeList (genPrimes userInput))
    (setq answer (calcGoldbach primeList userInput))


    (format t "~d : " userInput)
    (print answer)
    (terpri)
)


