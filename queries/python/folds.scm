; Fold functions bodies with their optional docstring if present
(function_definition
    body: (block)  @fold
)
(function_definition
    body: (block
        (expression_statement (string))? @fold
    )
)

; Fold class definitions bodies with their optional docstring if present
(class_definition
    body: (block) @fold
)
(class_definition
    body: (block
        (expression_statement (string))? @fold
    )
)

; Fold imports at top TODO: Doesnt work as intended
;(module .
;    (
;        [(import_statement) (import_from_statement)]
;        [(import_statement) (import_from_statement)]+
;    ) @fold
;)

; Fold main
(module
    (if_statement
        condition : (comparison_operator
            (identifier) @id (#match? @id "^__name__")
            [(string) (list)]
        )
    ) @fold
)

; Old default folds
;(while_statement (block) @fold)
;(for_statement (block) @fold)
;(if_statement (block) @fold)
;(with_statement (block) @fold)
;(try_statement (block) @fold)

;[
;  (import_from_statement)
;  (parameters)
;  (argument_list)
;
;  (parenthesized_expression)
;  (generator_expression)
;  (list_comprehension)
;  (set_comprehension)
;  (dictionary_comprehension)
;
;  (tuple)
;  (list)
;  (set)
;  (dictionary)
;
;  (string)
;] @fold
