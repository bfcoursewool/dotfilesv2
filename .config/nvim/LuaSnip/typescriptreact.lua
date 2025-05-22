local get_visual = function(args, parent)
  if (#parent.snippet.env.LS_SELECT_RAW > 0) then
    return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
  else  -- If LS_SELECT_RAW is empty, return a blank insert node
    return sn(nil, i(1))
  end
end

return {
  -- New interface
  s({trig="ni"},
    fmt(
      [[
      interface <> {
        <>
      }
    ]],
      {
        d(1, get_visual),
        i(2)
      },
      { delimiters = "<>" }
    )
  ), 

  -- New component
  s({trig="nc"},
    fmt(
      [[
      const <> = ({ <> }: <>): <> =>> {
        return (
          <>  
        )
      }
      
      export default <> 
    ]],
      {
        d(1, get_visual),
        i(2),
        i(3),
        i(4),
        i(5),
        rep(1),
      },
      { delimiters = "<>" }
    )
  ),

  -- New function, assigned to a const
  s({trig="nf"},
    fmt(
      [[
      const <> = <> (<>): <> =>> {
        <>   
      }
    ]],
      {
        d(1, get_visual),
        i(2),
        i(3),
        i(4),
        i(5),
      },
      { delimiters = "<>" }
    )
  ),

  -- New lambda / anonymous function
  s({trig="nl"},
    fmt(
      [[
      <> (<>): <> =>> {
        <>   
      }
    ]],
      {
        i(1),
        i(2),
        i(3),
        i(4),
      },
      { delimiters = "<>" }
    )
  ),

}
