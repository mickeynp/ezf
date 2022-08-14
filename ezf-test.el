(ert-deftest test-ezf-1 ()
  (let ((test1 (ezf-1 '("autodep8 - générateur de fichiers de contrôle de test DEP-8") "0"))
        (test2 (ezf-1 '("autodep8 - générateur de fichiers de contrôle de test DEP-8") "1"))
        (test3 (ezf-1 '("autodep8 - générateur de fichiers de contrôle de test DEP-8") "2"))
        (test4 (ezf-1 '("autodep8 - générateur de fichiers de contrôle de test DEP-8") "2-4"))
        (test5 (ezf-1 '("1071 helmcd -nw") "1-"))
        (test6 (ezf-1 '("1071 helmcd -nw") "1-2"))
        (test7 (ezf-1 '("1071 helmcd -nw")))
        (test8 (ezf-1 '("1071 helmcd -nw") "0-"))
        (test9 (ezf-1 '("1071 helmcd -nw") "0"))
        (test10 (ezf-1 '("1071 helmcd -nw") "1"))
        (test11 (ezf-1 '("1071 helmcd -nw") "2")))
    (should (string= test1 "autodep8"))
    (should (string= test2 "-"))
    (should (string= test3 "générateur"))
    (should (string= test4 "générateur de fichiers"))
    (should (string= test5 "helmcd -nw"))
    (should (string= test6 "helmcd -nw"))
    (should (string= test7 "1071 helmcd -nw"))
    (should (string= test8 "1071 helmcd -nw"))
    (should (string= test9 "1071"))
    (should (string= test10 "helmcd"))
    (should (string= test11 "-nw"))))
