defmodule HueSDK.API.Lights do
  @moduledoc """
  Interface to the Lights API
  https://developers.meethue.com/develop/hue-api/lights-api/
  """

  import HueSDK.API

  @doc """
  Gets a list of all lights that have been discovered by the bridge.
  """
  def get_all_lights(bridge) do
    request(
      :get,
      "http://#{bridge.host}/api/#{bridge.username}/lights",
      &Jason.decode!/1
    )
  end

  @doc """
  Gets a list of lights that were discovered the last time a search for new lights was performed.
  The list of new lights is always deleted when a new search is started.
  """
  def get_new_lights(bridge) do
    request(
      :get,
      "http://#{bridge.host}/api/#{bridge.username}/lights/new",
      &Jason.decode!/1
    )
  end

  @doc """
  Starts searching for new lights.

  The bridge will open the network for 40s. The overall search might take longer since the configuration of (multiple) new devices can take longer. If many devices are found the command will have to be issued a second time after discovery time has elapsed. If the command is received again during search the search will continue for at least an additional 40s.

  When the search has finished, new lights will be available using the get new lights command. In addition, the new lights will now be available by calling get all lights or by calling get group attributes on group 0. Group 0 is a special group that cannot be deleted and will always contain all lights known by the bridge.
  """
  def search_for_new_lights(bridge) do
    request(
      :post,
      "http://#{bridge.host}/api/#{bridge.username}/lights",
      &Jason.decode!/1
    )
  end

  @doc """
  Gets the attributes and state of a given light.
  """
  def get_light_attributes_and_state(bridge, id) do
    request(
      :get,
      "http://#{bridge.host}/api/#{bridge.username}/lights/#{id}",
      &Jason.decode!/1
    )
  end

  @doc """
  Used to rename lights.
  A light can have its name changed when in any state, including when it is unreachable or off.
  """
  def set_light_name(bridge, id, name) do
    request(
      :put,
      "http://#{bridge.host}/api/#{bridge.username}/lights/#{id}",
      Jason.encode!(%{name: name}),
      &Jason.decode!/1
    )
  end

  @doc """
  Allows the user to turn the light on and off, modify the hue and effects.
  """
  def set_light_state(bridge, id, state) do
    request(
      :put,
      "http://#{bridge.host}/api/#{bridge.username}/lights/#{id}/state",
      Jason.encode!(state),
      &Jason.decode!/1
    )
  end

  @doc """
  Deletes a light from the bridge.
  """
  def delete_light(bridge, id) do
    request(
      :delete,
      "http://#{bridge.host}/api/#{bridge.username}/lights/#{id}",
      &Jason.decode!/1
    )
  end
end
