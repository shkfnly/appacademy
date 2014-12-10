def transpose(mat)
  results = []
  while results.length < mat.length
    results << []
  end
  stoppoint = mat.count

  for i in 0...stoppoint
    for j in 0...stoppoint
      results[j][i] = mat[i][j]
    end
  end
  return results
end

puts transpose([
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8]
])
