<?php

namespace Tests\Unit;

use App\Dispatch\DispatchException;
use App\Firebird\FirebirdException;
use App\Support\Format;
use PHPUnit\Framework\TestCase;

class ExampleTest extends TestCase
{
    public function test_business_message_is_extracted_from_firebird_error(): void
    {
        $e = new FirebirdException("SQLSTATE[HY000]: General error: -836 exception 2 ERR_DISPATCH Oprirea nu este pe traseul tau At procedure 'SP_CW_PICKUP_START' line: 48, col: 9");

        $this->assertTrue($e->isBusinessRule());
        $this->assertSame('Oprirea nu este pe traseul tau', $e->userMessage());
        $this->assertNull((new FirebirdException('connection refused'))->userMessage());
    }

    public function test_business_messages_are_shown_with_diacritics(): void
    {
        $this->assertSame('Oprirea nu este pe traseul tău.', DispatchException::translate('Oprirea nu este pe traseul tau'));
        $this->assertSame('Cantitatea trebuie să fie între 0 și 2.', DispatchException::translate('Cantitatea trebuie sa fie intre 0 si 2.0000'));
        $this->assertSame('Text necunoscut', DispatchException::translate('Text necunoscut'));
    }

    public function test_lock_conflict_becomes_a_reload_message(): void
    {
        $wrapped = DispatchException::wrap(new FirebirdException('lock conflict on no wait transaction', '40001'));

        $this->assertInstanceOf(DispatchException::class, $wrapped);
        $this->assertStringContainsString('Reîncarcă', $wrapped->getMessage());
    }

    public function test_money_and_quantity_format(): void
    {
        $this->assertSame('5 100,00 lei', Format::money(5100, 498));
        $this->assertSame('450,00 USD', Format::money('450', 840));
        $this->assertSame('2', Format::qty('2.0000'));
        $this->assertSame('1,5', Format::qty(1.5));
        $this->assertSame('tel:+37369000011', Format::phoneUrl('+373 69 000 011'));
    }
}
