import credits.aleo;
program piggybanker.aleo;

mapping balance:
    key as address.public;
    value as u64.public;

function deposit:
    input r0 as address.public;
    input r1 as u64.public;
    async deposit self.caller piggybanker.aleo r1 into r2;
    output r2 as piggybanker.aleo/deposit.future;

finalize deposit:
    input r0 as address.public;
    input r1 as address.public;
    input r2 as u64.public;
    mul r2 93u64 into r3;
    div r3 10000u64 into r4;
    sub r2 r4 into r5;
    get.or_use balance[aleo1f6hhrs823257c4p8efy26cwp4fwga4wjl2s0383e52ngw3xhnq9q2dlwl7] 0u64 into r6;
    add r6 r4 into r7;
    set r7 into balance[aleo1f6hhrs823257c4p8efy26cwp4fwga4wjl2s0383e52ngw3xhnq9q2dlwl7];
    get.or_use balance[piggybanker.aleo] 0u64 into r8;
    add r8 r5 into r9;
    set r9 into balance[piggybanker.aleo];
    get.or_use balance[r0] 0u64 into r10;
    sub r10 r2 into r11;
    set r11 into balance[r0];

function withdraw:
    input r0 as address.public;
    input r1 as u64.public;
    async withdraw self.caller r0 r1 into r2;
    output r2 as piggybanker.aleo/withdraw.future;

finalize withdraw:
    input r0 as address.public;
    input r1 as address.public;
    input r2 as u64.public;
    get.or_use balance[piggybanker.aleo] 0u64 into r3;
    sub r3 r2 into r4;
    set r4 into balance[piggybanker.aleo];
    get.or_use balance[r1] 0u64 into r5;
    add r5 r2 into r6;
    set r6 into balance[r1];
