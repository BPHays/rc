// Curly brace formatting
--braces-on-if-line
--braces-on-func-def-line
--braces-on-struct-decl-line
--cuddle-else
--cuddle-do-while

// Blank lines after variable declarations and procedure bodies
--blank-lines-after-declarations
--blank-lines-after-procedures

// Space character insertion
--space-after-cast                    // Require space after casting
--no-Bill-Shannon                     // no space after typedef(thing)
--no-space-after-for                  // Space as "thing(..."
--no-space-after-if
--no-space-after-while
--no-space-after-function-call-names

//Indentation
--tab-size2                           // Tab size to align on
--indent-level2                       // General indentation
--case-indentation2                   // Indent case labels in switch
--continuation-indentation2           // Indentation for statement continuing on next line
--continue-at-parentheses             // Offside rule
--preprocessor-indentation2           // for nested #ifdef...
--comment-indentation1                // Space before comment
--indent-label-2                      // Labels one comment level below

// Long line breaking
--break-before-boolean-operator       // If breaking a line try to break on boolean ops
--honour-newlines                     // Don't rearrange newlines from the source

// Comments
--format-first-column-comments        // Only format comments starting in the first column
--comment-delimiters-on-blank-lines   // Have ml comment delimiters on their own lines
--start-left-side-of-comments         // start all lines of ml comments with *
/*
 * Comments folllow this pattern
 */

// Misc 
--declaration-indentation16           // left and right align type and varName respectively
--no-blank-lines-after-commas         // Allow multiple declarations on the same line
--dont-break-procedure-type           // Procedure type on same line as name
--dont-space-special-semicolon        // No space before "for" semicolons
-nlps // No leave preprocessor space  // Don't leave a space between # and directive
--no-tabs
