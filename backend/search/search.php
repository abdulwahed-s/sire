<?php

include "../connect.php";

$searchitem = filterRequest("searchitem");

getAllData("itemsview", "item_name LIKE '%$searchitem%' OR item_name_es LIKE '%$searchitem%'  OR item_name_ar LIKE '%$searchitem%'");
