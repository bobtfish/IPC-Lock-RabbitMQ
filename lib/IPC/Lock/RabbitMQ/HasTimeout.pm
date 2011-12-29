package IPC::Lock::RabbitMQ::HasTimeout;
use Moose::Role;
use MooseX::Types::Moose qw/ Int /;
use AnyEvent;
use namespace::autoclean;

has timeout => (
    is => 'ro',
    isa => Int,
    default => 30,
);

sub _gen_timer {
    my ($self, $cv, $name) = @_;
    return unless $self->timeout;
    AnyEvent->timer(after => $self->timeout, cb => sub { $cv->throw("$name  timed out after " . $self->timeout) });
}

1;

