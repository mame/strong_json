class StrongJSON
  def initialize: { (StrongJSON) -> void } -> any
  def let: (Symbol, ty) -> void
  include StrongJSON::Types
end

StrongJSON::VERSION: String

interface StrongJSON::_Schema[T]
  def coerce: (any, ?path: Type::ErrorPath) -> T
  def =~: (any) -> bool
  def to_s: -> String
  def is_a?: (any) -> bool
  def `alias`: -> Symbol?
  def with_alias: (Symbol) -> self
  def ==: (any) -> bool
  def yield_self: [X] () { (self) -> X } -> X
end

type StrongJSON::ty = _Schema[any]

module StrongJSON::Types
  def object: [X] (Hash[Symbol, ty]) -> Type::Object[X]
            | () -> Type::Object[bot]
  def object?: [X] (Hash[Symbol, ty]) -> Type::Optional[X]
             | () -> Type::Optional[bot]
  def any: () -> Type::Base[any]
  def any?: () -> Type::Optional[any]
  def optional: [X] (_Schema[X]) -> Type::Optional[X]
              | () -> Type::Optional[any]
  def string: () -> Type::Base[String]
  def string?: () -> Type::Optional[String]
  def number: () -> Type::Base[Numeric]
  def number?: () -> Type::Optional[Numeric]
  def numeric: () -> Type::Base[Numeric]
  def numeric?: () -> Type::Optional[Numeric]
  def integer: () -> Type::Base[Integer]
  def integer?: () -> Type::Optional[Integer]
  def boolean: () -> Type::Base[bool]
  def boolean?: () -> Type::Optional[bool]
  def symbol: () -> Type::Base[Symbol]
  def symbol?: () -> Type::Optional[Symbol]
  def array: [X] (_Schema[X]) -> Type::Array[X]
           | () -> Type::Array[any]
  def array?: [X] (_Schema[X]) -> Type::Optional[::Array[X]]
  def literal: [X] (X) -> Type::Literal[X]
  def literal?: [X] (X) -> Type::Optional[X]
  def enum: [X] (*_Schema[any], ?detector: Type::detector?) -> Type::Enum[X]
  def enum?: [X] (*_Schema[any], ?detector: Type::detector?) -> Type::Optional[X]
  def hash: [X] (_Schema[X]) -> Type::Hash[X]
          | any
  def hash?: [X] (_Schema[X]) -> Type::Optional[Hash[Symbol, X]]
end

class StrongJSON::ErrorReporter
  attr_reader path: Type::ErrorPath
  @string: String

  def initialize: (path: Type::ErrorPath) -> any
  def format: -> void
  def pretty_str: (ty, ?expand_alias: bool) -> ::String

  private
  def format_trace: (path: Type::ErrorPath, ?index: Integer) -> void
  def format_aliases: (path: Type::ErrorPath, where: ::Array[String]) -> ::Array[String]
  def format_single_alias: (Symbol, ty) -> String
  def pretty: (ty, any, ?expand_alias: bool) -> void
end
