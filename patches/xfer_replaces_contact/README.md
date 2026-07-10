# Xfer Replaces Contact patch

PJSIP's attended transfer (`pjsua_call_xfer_replaces()` / pjsua2 `Call::xferReplaces()`) builds the
`REFER` request with a `Replaces` target derived from the destination dialog's **AOR** (address of
record). When the destination's actual registration binding differs from the AOR — e.g. after a
network change or NAT rebinding — the resulting `REFER`/`Replaces` may not target the reachable
dialog and the transfer can fail.

This patch adds a variant that builds the `Replaces` target from the destination dialog's **remote
Contact URI** instead, falling back to the AOR when no Contact is available:

* C API: `pjsua_call_xfer_replaces_contact()` in `pjsip/include/pjsua-lib/pjsua.h` and
  `pjsip/src/pjsua-lib/pjsua_call.c`.
* pjsua2 C++ binding: `Call::xferReplacesContact()` in `pjsip/include/pjsua2/call.hpp` and
  `pjsip/src/pjsua2/call.cpp`.

Because `pjsip-apps/src/swig/pjsua2.i` does `%include "pjsua2/call.hpp"`, SWIG automatically wraps
the new public method, so `xferReplacesContact()` appears in the generated Java `Call` class
(`org/pjsip/pjsua2/Call.java`) with no SWIG interface changes required.

The patch is enabled by the `XFER_REPLACES_CONTACT` switch in `config.conf` (default `1`).

Moreover, a default change was rejected [in the upstream repo](https://github.com/pjsip/pjproject/pull/4807)
