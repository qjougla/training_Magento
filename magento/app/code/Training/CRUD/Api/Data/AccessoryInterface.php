<?php

 namespace Training\CRUD\Api\Data;

 interface AccessoryInterface
 {
     //const : accessory_id, name, description, product_id
     const ACCESSORY_ID = 'accessory_id';
     const ACCESSORY_NAME = 'name';
     const ACCESSORY_DESCRIPTION = 'description';
     const ACCESSORY_PRODUCT_ID = 'product_id';

     /**
      * @return mixed
      */
     public function getAccessoryId();

     /**
      * @param $accessoryId
      * @return mixed
      */
     public function setAccessoryId($accessoryId);

     /**
      * @return mixed
      */
     public function getName();

     /**
      * @param $name
      * @return mixed
      */
     public function setName($name);

     /**
      * @return mixed
      */
     public function getDescription();

     /**
      * @param $description
      * @return mixed
      */
     public function setDescription($description);

     /**
      * @return mixed
      */
     public function getProductId();

     /**
      * @param $productId
      * @return mixed
      */
     public function setProductId($productId);
 }
