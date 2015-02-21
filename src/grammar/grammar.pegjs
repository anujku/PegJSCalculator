start
    = any

additive
    = left:primary "+" right:any { return left + right; }

multiplicative
    = left:primary "*" right:any { return left * right; }

subtractive
    = left:primary "-" right:any { return left - right; }

divisive
    = left:primary "/" right:any { return left / right; }

power
    = left:primary "^" right:any { return Math.pow(left, right); }

frac
    = "\\frac{" nominator:any "}{" denominator:any "}"
    {
        if (denominator === 0) {
            if (nominator < 0) {
                return Number.POSITIVE_INFINITY;
            } else {
                return Number.NEGATIVE_INFINITY;
            }
        } else {
            return nominator / denominator;
        }
    }

abs
    = "\\abs{" argument:any "}"
    {
        return Math.abs(argument);
    }

any
    = multiplicative
    / divisive
    / power
    / additive
    / subtractive
    / primary

primary
    = frac
    / abs
    / float
    / integer
    / "(" any:any ")" { return any; }
    / "" { return 0; }

float "float"
    = left:[0-9]+ "." right:[0-9]+ { return parseFloat(left.join("") + "." + right.join("")); }

integer "integer"
    = digits:[0-9]+ { return parseInt(digits.join(""), 10); }
