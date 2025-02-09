function m_hyper = m_hyper_value(ObjectiveScores)

m2=[0,0,0];
m = getMaxScorePerObjective(ObjectiveScores);
if m(1)>m2(1)&&m(1)<100
    m2(1)=m(1);
end
if m(2)>m2(2)&&m(2)<100
    m2(2)=m(2);
end
if m(3)>m2(3)&&m(3)<100
    m2(3)=m(3);
end

m_hyper = m2;