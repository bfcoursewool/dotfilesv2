local get_visual = function(args, parent)
  if (#parent.snippet.env.LS_SELECT_RAW > 0) then
    return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
  else  -- If LS_SELECT_RAW is empty, return a blank insert node
    return sn(nil, i(1))
  end
end

return {
  s({trig="nint"},
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

  s({trig="ncmp"},
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

  s({trig="nfn"},
    fmt(
      [[
      const <> = (<>): <> =>> {
        <>   
      }
    ]],
      {
        d(1, get_visual),
        i(2),
        i(3),
        i(4),
      },
      { delimiters = "<>" }
    )
  ),
}
