<?php

namespace Training\CRUD\Model\ResourceModel\Accessory;

use Training\CRUD\Model\ResourceModel\Accessory as AccessoryResource;
use Training\CRUD\Model\Data\Accessory as AccessoryModel;

class Collection extends \Magento\Framework\Model\ResourceModel\Db\Collection\AbstractCollection
{
    protected $_idFieldName = 'accessory_id';

    public function _construct()
    {
        $this->_init(AccessoryModel::class, AccessoryResource::class);
    }
}
