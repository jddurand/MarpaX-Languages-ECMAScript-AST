use strict;
use warnings FATAL => 'all';

package MarpaX::Languages::ECMAScript::AST::Exceptions;

use Exception::Class (
    'MarpaX::Languages::ECMAScript::AST::Exception::InternalError' =>
        { description => 'Internal error',
          alias  => 'InternalError',},
    'MarpaX::Languages::ECMAScript::AST::Exception::SyntaxError' =>
        { description => 'Syntax error',
          alias  => 'SyntaxError'},
    ,
);

use Exporter 'import';
our @EXPORT_OK = qw/InternalError SyntaxError/;
our %EXPORT_TAGS = ('all' => [ @EXPORT_OK ]);

1;
