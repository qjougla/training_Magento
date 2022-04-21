<?php

namespace Training\CRUD\Api;

use Magento\Framework\Api\SearchResultsInterface;
use Magento\Framework\Api\SearchCriteriaInterface;
use Magento\Framework\Exception\LocalizedException;
use Training\CRUD\Api\Data\AccessoryInterface;

interface AccessoryRepositoryInterface
{
    // TODO save(), get(), getList, delete(), deleteById()
    /**
     * @param AccessoryInterface $accessory
     * @return mixed
     * @throws LocalizedException
     */
    public function delete(AccessoryInterface $accessory);

    /**
     * @param $id
     * @return mixed
     * @throws LocalizedException
     */
    public function deleteById($id);

    /**
     * @param $id
     * @return mixed
     * @throws LocalizedException
     */
    public function get($id);

    /**
     * @param SearchCriteriaInterface $searchCriteria
     * @return SearchResultsInterface
     * @throws LocalizedException
     */
    public function getList(SearchCriteriaInterface $searchCriteria);

    /**
     * @param AccessoryInterface $accessory
     * @return AccessoryInterface
     * @throws LocalizedException
     */
    public function save(AccessoryInterface $accessory);
}
