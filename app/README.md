## Использование

### Elastic search

#### Подключение
```php
<?php
/** @var Elastic\Elasticsearch\Client $client */
$client = DB::connection('elasticsearch')->getClient();
$response = $client->ping();
dd($response->getStatusCode());
?>
```

#### Миграция
```php
<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use PDPhilip\Elasticsearch\Schema\IndexBlueprint;
use PDPhilip\Elasticsearch\Schema\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create(
            'shit',
            function (IndexBlueprint $index) {
                $index->map('dynamic', 'strict');

                $index->text('name1')
                    ->index(false)
                    ->copyTo('names');

                $index->text('name2')
                    ->index(false)
                    ->copyTo('names');

                $index->keyword('names');
                $index->keyword('domain');
                $index->keyword('bind_category');
                $index->boolean('active');
                $index->keyword('item_id');
                $index->boolean('derivative.have_derivative');
                $index->boolean('derivative.allow_export');
                $index->boolean('derivative.active_set_manually');
                $index->boolean('derivative.name2_set_manually');
                $index->boolean('derivative.is_duplicate');
            }
        );
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::deleteIfExists(
            'shit',
        );
    }
};
```
