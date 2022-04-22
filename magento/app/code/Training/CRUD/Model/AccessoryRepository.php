<?php

namespace Training\CRUD\Model;

use Training\CRUD\Api\Data\AccessoryInterface;
use Training\CRUD\Api\AccessoryRepositoryInterface;
use Training\CRUD\Model\ResourceModel\Accessory as AccessoryResource;
use Training\CRUD\Model\ResourceModel\Accessory\Collection as AccessoryCollection;
use Magento\Framework\Api\SearchCriteria\CollectionProcessorInterface;
use Magento\Framework\Api\SearchCriteriaInterface;
use Magento\Framework\Api\SearchResultsInterfaceFactory;
use Magento\Framework\Exception\CouldNotDeleteException;
use Magento\Framework\Exception\CouldNotSaveException;
use Magento\Framework\Exception\NoSuchEntityException;

class AccessoryRepository implements AccessoryRepositoryInterface
{
    /**
     * @var SearchResultsInterfaceFactory
     */
    private $searchResultsFactory;
    /**
     * @var CollectionProcessorInterface
     */
    private $collectionProcessor;
    /**
     * @var AccessoryInterface
     */
    private $accessoryInterface;
    /**
     * @var AccessoryResource
     */
    private $accessoryResource;
    /**
     * @var AccessoryCollection
     */
    private $collection;

    public function __construct(
        SearchResultsInterfaceFactory $searchResultsFactory,
        CollectionProcessorInterface  $collectionProcessor,
        AccessoryInterface $accessoryInterface,
        AccessoryResource $accessoryResource,
        AccessoryCollection $collection
    )
    {
        $this->searchResultsFactory = $searchResultsFactory;
        $this->collectionProcessor = $collectionProcessor;
        $this->accessoryInterface = $accessoryInterface;
        $this->accessoryResource = $accessoryResource;
        $this->collection = $collection;
    }

    /**
     * @inheritDoc
     */
    public function delete(AccessoryInterface $accessory)
    {
        try {
            $this->accessoryResource->delete($accessory);
        }catch (\Exception $e) {
            throw new CouldNotDeleteException(__('Could not delete the Accessory'), $e);
        }
        return true;
    }

    /**
     * @inheritDoc
     */
    public function deleteById($id)
    {
        $accessory = $this->get($id);
        $this->delete($accessory);
    }

    /**
     * @inheritDoc
     */
    public function get($id)
    {
        $accessory = $this->accessoryInterface;
        $this->accessoryResource->load($accessory, $id);
        if (!$accessory->getAccessoryId()) {
            throw new NoSuchEntityException(__("Could not found with this id : $id"));
        }
        return $accessory;
    }

    /**
     * @inheritDoc
     */
    public function getList(SearchCriteriaInterface $searchCriteria)
    {
        $searchResult = $this->searchResultsFactory->create();
        $collection = $this->collection;
        $this->collectionProcessor->process($searchCriteria, $collection);

        $searchResult->setSearchCriteria($searchCriteria);
        $searchResult->setItems($collection->getItems());
        $searchResult->setTotalCount($collection->getSize());

        return $searchResult;
    }

    /**
     * @inheritDoc
     */
    public function save(AccessoryInterface $accessory)
    {
        try{
            $accessory = $this->accessoryResource->save($accessory);
            return $accessory;
        } catch (\Exception $e) {
            throw new CouldNotSaveException(__('Could not save the accessory.'), $e);
        }
    }
}
