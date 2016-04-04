module Haskakafka.Consumer.Internal.Types

where

import           Haskakafka.InternalTypes

newtype ConsumerGroupId = ConsumerGroupId String deriving (Show, Eq)

-- | Topic name to be consumed
--
-- Wildcard (regex) topics are supported by the librdkafka assignor:
-- any topic name in the topics list that is prefixed with @^@ will
-- be regex-matched to the full list of topics in the cluster and matching
-- topics will be added to the subscription list.
newtype TopicName =
    TopicName String -- ^ a simple topic name or a regex if started with @^@
    deriving (Show, Eq)

-- | Comma separated broker:port string (e.g. @broker1:9092,broker2:9092@)
newtype BrokersString = BrokersString String deriving (Show, Eq)

-- | Indicates how offsets are to be synced to disk
data OffsetStoreSync =
      OffsetSyncDisable       -- ^ Do not sync offsets (in Kafka: -1)
    | OffsetSyncImmediate     -- ^ Sync immediately after each offset commit (in Kafka: 0)
    | OffsetSyncInterval Int  -- ^ Sync after specified interval in millis

-- | Indicates the method of storing the offsets
data OffsetStoreMethod =
      OffsetStoreBroker                         -- ^ Offsets are stored in Kafka broker (preferred)
    | OffsetStoreFile FilePath OffsetStoreSync  -- ^ Offsets are stored in a file (and synced to disk according to the sync policy)

-- | Kafka topic partition structure
data KafkaTopicPartition = KafkaTopicPartition
  { ktpTopicName :: TopicName
  , ktpPartition :: Int
  , ktpOffset    :: KafkaOffset } deriving (Show, Eq)

