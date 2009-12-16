# Copyright (c) 2009 Zmanda, Inc.  All Rights Reserved.
#
# This program is free software; you can redistribute it and/or modify it
# under the terms of the GNU General Public License version 2 as published
# by the Free Software Foundation.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
# for more details.
#
# You should have received a copy of the GNU General Public License along
# with this program; if not, write to the Free Software Foundation, Inc.,
# 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
#
# Contact information: Zmanda Inc, 465 S. Mathilda Ave., Suite 300
# Sunnyvale, CA 94086, USA, or: http://www.zmanda.com

use Test::More tests => 55;
use IO::Socket;
use strict;

use lib "@amperldir@";
use Installcheck;
use Installcheck::Mock;
use Amanda::NDMP qw( :constants );

my $ndmp_port = Installcheck::get_unused_port();
my $tapefile = Installcheck::Mock::run_ndmjob($ndmp_port);
my $nc;

$nc = Amanda::NDMP::NDMPConnection->new("127.0.0.1", $ndmp_port, "test", "ndmp", "ndmp");
ok($nc, "constructor creates an object");
is($nc->err_code(), 0, "and no error is set");

$nc->set_verbose(1);

# can't test the scsi_* methods in the general case, because we have nothing to talk
# to -- but they were tested once, never fear!

ok($nc->tape_open($tapefile, $NDMP9_TAPE_RDWR_MODE),
    "tape_open");

is_deeply([ $nc->tape_write("ab"x8) ], [1, 16],
    "tape_write");

is_deeply([ $nc->tape_write("cd"x8) ], [1, 16],
    "tape_write");

ok($nc->tape_mtio($NDMP9_MTIO_EOF, 1),
    "tape_mtio (eof)");

ok($nc->tape_mtio($NDMP9_MTIO_REW, 1),
    "tape_mtio (rewind)");

is_deeply([ $nc->tape_read(32) ], [1, "ab"x8], "tape_read");
is_deeply([ $nc->tape_read(32) ], [1, "cd"x8], "tape_read");

is_deeply([ $nc->tape_get_state() ], [1, 0, 0, 2], "tape_get_state");

ok($nc->tape_close(),
    "tape_close");

Installcheck::Mock::cleanup_ndmjob();