# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

window.MusicSearch = do ->

  setFromField = (from) ->
    $("#from").val(from)

  setNext: (next) ->
    setFromField(next)

  initialize: (form, results) ->
    form.on("ajax:success", (e, data, status, xhr) ->
      results.html(data)
    ).on("ajax:error", (e, xhr, status, error) ->
      console?.error error
    )
    $("#query", form).on("change", ->
      setFromField(0)
    )
    $("#field", form).on("change", ->
      setFromField(0)
    )

$ ->
  MusicSearch.initialize($("#search-form"), $("#search-results"))
