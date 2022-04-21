<?php

namespace Training\CRUD\Model\ResourceModel;

class Accessory extends \Magento\Framework\Model\ResourceModel\Db\AbstractDb
{

    /**
     * @inheritDoc
     */
    protected function _construct()
    {
        $this->_init('training_crud_accessory', 'accessory_id');
    }
}
